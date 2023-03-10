terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project     = "happy-project-mayank"
  region      = "us-central1"
  credentials = "C:\Users\Administrator\AppData\Roaming\gcloud\application_default_credentials.json"
}

resource "google_pubsub_schema" "example" {
  name = "testSchema"
  type = "AVRO"
  definition = "{\n  \"type\" : \"record\",\n  \"name\" : \"Avro\",\n  \"fields\" : [\n    {\n      \"name\" : \"StringField\",\n      \"type\" : \"string\"\n    },\n    {\n      \"name\" : \"IntField\",\n      \"type\" : \"int\"\n    }\n  ]\n}\n"
}

resource "google_pubsub_topic" "example" {
  name = "testpubsub"
  labels = {
    env = "dev"
  }
  message_retention_duration = "86600s"
  message_storage_policy {
    allowed_persistence_regions = [
      "us-central1",
    ]
  }
  depends_on = [google_pubsub_schema.example]
  schema_settings {
    schema = "projects/happy-project-mayank/schemas/testSchema"
    encoding = "JSON"
  }
}

output "pubsubid" {
  value = google_pubsub_topic.example.id
  
}