terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.46.0"
    }
  }
}

provider "google" {
#  credentials = file("service.json")
  project = "${var.project_id}"
  region  = "${var.region}"
}

resource "google_sql_database_instance" "database" {
  name             = "main-instance"
  database_version = "POSTGRES_14"
  region           = "europe-west3"

  settings {
    tier = "db-f1-micro"
#    disk_type = "PD_HDD"
  }
}

resource "google_storage_bucket" "dagster_io" {
  name          = "dpipeline_dagster_io_storage"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true

  public_access_prevention = "enforced"

}