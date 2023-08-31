import { Controller } from "@hotwired/stimulus";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    resortInfo: Boolean
  }

  static targets = ["map"]

  connect() {
    console.log("Conected!");
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.mapTarget, // container ID
      style: 'mapbox://styles/mapbox/streets-v12', // style URL
    });

    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    // this.#setupCardScrollListener(); // New line to set up scroll listener
    if (this.resortInfoValue) {
      this.#addSkiResortInfo()
    }
  }

  #addMarkersToMap() {
    this.markersValue.forEach((markerData) => {
      const customMarker = document.createElement("div");
      customMarker.innerHTML = markerData.marker_html;
      const popup = new mapboxgl.Popup().setHTML(markerData.info_window_html);

      new mapboxgl.Marker(customMarker)
        .setLngLat([markerData.lng, markerData.lat])
        .setPopup(popup)
        .addTo(this.map);

      // Attach the ski resort ID to the marker element
      customMarker.setAttribute("data-ski-resort-id", markerData.marker_id);
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

  #findVisibleCard(cardsContainer) {
    const cards = cardsContainer.querySelectorAll(".show-card");
    const containerRect = cardsContainer.getBoundingClientRect();

    for (const card of cards) {
      const cardRect = card.getBoundingClientRect();

      if (
        cardRect.left >= containerRect.left &&
        cardRect.right <= containerRect.right
      ) {
        return card; // Return the first visible card
      }
    }

    return null; // No visible card found
  }

  updateMarkerColors(event) {
    console.log(event);
    const visibleCard = this.#findVisibleCard(event.target)
    if (!visibleCard) {
      return
    }
    const skiResortId = visibleCard.getAttribute("data-ski-resort-id");
    const skiResortCoordinates = JSON.parse(visibleCard.getAttribute("data-ski-resort-coordinates"));
    console.log(visibleCard);
    console.log(skiResortId);

    const all_markers = document.querySelectorAll(".mapboxgl-marker")
    console.log(all_markers);
    all_markers.forEach(marker => {
      console.log(marker);
      console.log(marker.dataset.skiResortId);
      console.log(skiResortId);
      console.log(marker.marker_id === skiResortId);

      if (marker.dataset.skiResortId === skiResortId) {
        // Change marker color for the visible card
        marker.style = " background-color: rgba(255, 130, 153, 0.3); border-radius: 50%;";
      } else {
        // Reset color for other markers
        marker.style = " background-color: rgba(255, 130, 153, 0);";
      }
    });

    this.map.flyTo({
      center:skiResortCoordinates,
      zoom: 8,
      speed: 0.4,
    });
  }

  // #setupCardScrollListener() {
  //   const cardsContainer = document.querySelector("[data-controller='map']");
  //   cardsContainer.addEventListener("scroll", () => {
  //     const visibleCard = this.#findVisibleCard(cardsContainer);
  //     if (visibleCard) {
  //       this.updateMarkerColors(visibleCard);
  //     }
  //   });
  // }
}
