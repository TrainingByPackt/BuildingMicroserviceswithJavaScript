access_key_id         = ENV["GOOGLE_STORAGE_ACCESS_KEY_ID"] || ""
secret_access_key     = ENV["GOOGLE_STORAGE_SECRET_ACCESS_KEY"] || ""
bucket                = ENV["GOOGLE_STORAGE_BUCKET"] || "bucket"

FogStorage = Fog::Storage.new(
  provider: "Google",
  google_storage_access_key_id:     access_key_id,
  google_storage_secret_access_key: secret_access_key
)

StorageBucket = FogStorage.directories.new key: bucket
