require 'sequel'

DB = Sequel.sqlite('db/tienda_virtual.db')
Sequel::Model.plugin :json_serializer