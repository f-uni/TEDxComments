###### TEDx-Load-Aggregate-Model
######

import sys
import json
import pyspark
from pyspark.sql.functions import col, collect_list, array_join

from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job




##### FROM FILES
tedx_dataset_path = "s3://fc-tedx-2024-data/csv/final_list.csv"

###### READ PARAMETERS
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

##### START JOB CONTEXT AND JOB
sc = SparkContext()


glueContext = GlueContext(sc)
spark = glueContext.spark_session


    
job = Job(glueContext)
job.init(args['JOB_NAME'], args)


#### READ INPUT FILES TO CREATE AN INPUT DATASET
tedx_dataset = spark.read \
    .option("header","true") \
    .option("quote", "\"") \
    .option("escape", "\"") \
    .csv(tedx_dataset_path)
    
tedx_dataset.printSchema()


#### FILTER ITEMS WITH NULL POSTING KEY
count_items = tedx_dataset.count()
count_items_null = tedx_dataset.filter("id is not null").count()

print(f"Number of items from RAW DATA {count_items}")
print(f"Number of items from RAW DATA with NOT NULL KEY {count_items_null}")

## READ THE DETAILS
details_dataset_path = "s3://fc-tedx-2024-data/csv/details.csv"
details_dataset = spark.read \
    .option("header","true") \
    .option("quote", "\"") \
    .option("escape", "\"") \
    .csv(details_dataset_path)

details_dataset = details_dataset.select(col("id").alias("id_ref"),
                                         col("description"),
                                         col("duration"),
                                         col("publishedAt"))

# AND JOIN WITH THE MAIN TABLE
tedx_dataset_main = tedx_dataset.join(details_dataset, tedx_dataset.id == details_dataset.id_ref, "left") \
    .drop("id_ref")

tedx_dataset_main.printSchema()

## READ TAGS DATASET
tags_dataset_path = "s3://fc-tedx-2024-data/csv/tags.csv"
tags_dataset = spark.read.option("header","true").csv(tags_dataset_path)


# CREATE THE AGGREGATE MODEL, ADD TAGS TO TEDX_DATASET
tags_dataset_agg = tags_dataset.groupBy(col("id").alias("id_ref")).agg(collect_list("tag").alias("tags"))
tags_dataset_agg.printSchema()
tedx_dataset_agg = tedx_dataset_main.join(tags_dataset_agg, tedx_dataset.id == tags_dataset_agg.id_ref, "left") \
    .drop("id_ref") \
    .select(col("id").alias("_id"), col("*")) \
    .drop("id")

tedx_dataset_agg.printSchema()

## READ THE IMAGES
images_dataset_path = "s3://fc-tedx-2024-data/csv/images.csv"
images_dataset = spark.read \
    .option("header","true") \
    .option("quote", "\"") \
    .option("escape", "\"") \
    .csv(images_dataset_path)

images_dataset= images_dataset.select(col("id").alias("id_ref"), col("url").alias("img_url"))

# AND JOIN WITH THE MAIN TABLE
tedx_dataset_agg_img = tedx_dataset_agg.join(images_dataset, tedx_dataset_agg._id == images_dataset.id_ref, "left") \
    .drop("id_ref") 

tedx_dataset_agg_img.printSchema()


## READ WATCH NEXT DATASET
wn_dataset_path = "s3://fc-tedx-2024-data/csv/related_videos.csv"
wn_dataset = spark.read.option("header","true").csv(wn_dataset_path)

wn_real_id = wn_dataset.select(col("internalId").alias("internal"), col("id").alias("real_id")).distinct()

wn_dataset = wn_dataset.join(wn_real_id, wn_dataset.related_id==wn_real_id.internal, "left")

wn_dataset.printSchema()

# CREATE THE AGGREGATE MODEL, ADD TAGS TO TEDX_DATASET
wn_dataset_agg = wn_dataset.groupBy(col("id").alias("id_ref")).agg(collect_list("real_id").alias("related_videos"))
wn_dataset_agg.printSchema()
tedx_dataset_agg_img_wn = tedx_dataset_agg_img.join(wn_dataset_agg, tedx_dataset_agg_img._id == wn_dataset_agg.id_ref, "left") \
    .drop("id_ref")

wn_dataset_views = wn_dataset.select(col("real_id"), col("viewedCount").alias("views")).distinct()
tedx_dataset_agg_img_wn_views = tedx_dataset_agg_img_wn.join(wn_dataset_views, tedx_dataset_agg_img_wn._id == wn_dataset_views.real_id, "left") \
    .drop("real_id")


write_mongo_options = {
    "connectionName": "tedx2024",
    "database": "tedx_comments",
    "collection": "tedx_data",
    "ssl": "true",
    "ssl.domain_match": "false"}
from awsglue.dynamicframe import DynamicFrame
tedx_dataset_dynamic_frame = DynamicFrame.fromDF(tedx_dataset_agg_img_wn_views, glueContext, "nested")

glueContext.write_dynamic_frame.from_options(tedx_dataset_dynamic_frame, connection_type="mongodb", connection_options=write_mongo_options)
