import Config

data_dir = Path.expand("priv/tzdata")

config :tzdata,
  data_dir: data_dir

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase
