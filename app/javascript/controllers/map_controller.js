import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    resortInfo: Boolean
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element, // container ID
      style: 'mapbox://styles/mapbox/streets-v12', // style URL
    });
  this.#addMarkersToMap()
  this.#fitMapToMarkers()
  if (this.resortInfoValue) {
    this.#addSkiResortInfo()
  }
}

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 15 })
  }

  #addSkiResortInfo() {
    this.map.on('load', () => {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 12 })

      // // Add a data source containing GeoJSON data.
      // this.map.addSource('ski_areas', {
      // type: 'geojson',
      // data: '/geojson/ski_areas.geojson'
      // });

      // // Add a new layer to visualize the polygon.
      // this.map.addLayer({
      // id: 'ski_areas',
      // type: 'fill',
      // source: 'ski_areas', // reference the data source
      // layout: {},
      // paint: {
      // 'fill-color': '#0080ff', // blue color fill
      // 'fill-opacity': 0.5
      // }
      // });
      // // Add a black outline around the polygon.
      // this.map.addLayer({
      // id: 'outline',
      // type: 'line',
      // source: 'maine',
      // layout: {},
      // paint: {
      // 'line-color': '#000',
      // 'line-width': 3
      // }
      // });
      })
}
}
