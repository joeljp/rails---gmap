class DistrictsController < ApplicationController
  require 'geo_ruby'
  # GET /districts
  # GET /districts.json
  def index

#    @districts = District.all # District.all is a call to District model's all => array (from db) stored in instance var @districts
#    @districts = District.select("knr, knavn, ksenter, ST_AsEWKT(the_geom)")
    @districts = District.select("kno, name, ST_AsGeoJSON(geom)")
#    @districts = District.select("knr, knavn, ksenter, ST_AsGeoJSON(the_geom)")
#    @districts.map!{|e|
#      e = GeoRuby::SimpleFeatures::Geometry.from_hex_ewkb(e)
#    }
      

#    @json = District.all.to_gmaps4rails
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @districts } # http://localhost:3000/districts.json to get this
    end
  end

  # GET /districts/1
  # GET /districts/1.json
  def show

    @district = District.District.select("kno, name, ST_AsGeoJSON(geom) where kno = " + params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @district }
    end
  end

  def plot

    poly = zcta.the_geom[0]
    envelope = poly.envelope
    
    
    @id = zcta.id
    @map = Variable.new("map")
    
    @polygon = GPolygon.from_georuby(poly,"#000000",0,0.0,"#ff0000",0.6)

    @center = GLatLng.from_georuby(envelope.center)
    @zoom = @map.get_bounds_zoom_level(GLatLngBounds.from_georuby(envelope))
    
  end
end
