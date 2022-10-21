resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

this_is_a_map 'yes'

server_scripts {
  "server-side/server.lua",
}

client_scripts {
  "client-side/client.lua",
}

files {
  "interiorproxies.meta",
  'data/mota/handling.meta',
  'data/mota/vehiclelayouts.meta',
  'data/mota/vehicles.meta',
  'data/mota/carvariations.meta',
  'data/mota/carcols.meta',
}

data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'
data_file 'HANDLING_FILE' 'data/mota/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/mota/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/mota/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/mota/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/mota/carvariations.meta'
