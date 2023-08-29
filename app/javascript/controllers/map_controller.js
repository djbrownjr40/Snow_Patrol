import { Controller } from "@hotwired/stimulus";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  static targets = ["map"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.mapTarget, // container ID
      style: 'mapbox://styles/mapbox/streets-v12', // style URL
    });
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.#setupCardScrollListener(); // New line to set up scroll listener
  }

  #addMarkersToMap() {
    this.markersValue.forEach((markerData) => {
      const customMarker = document.createElement("div");
      customMarker.innerHTML = markerData.marker_html;
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

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

  #findVisibleCard(cardsContainer) {
    const cards = cardsContainer.querySelectorAll(".card");
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
    const skiResortId = visibleCard.getAttribute("data-ski-resort-id");
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
        marker.innerHTML = "<i class='fa-regular fa-snowflake' style='color: #ff8298;'></i>";
      } else {
        // Reset color for other markers
        marker.innerHTML = "<i class='fa-regular fa-snowflake' style='color: #073763;'></i>";
      }
    });
  }

  #setupCardScrollListener() {
    const cardsContainer = document.querySelector("[data-controller='map']");
    cardsContainer.addEventListener("scroll", () => {
      const visibleCard = this.#findVisibleCard(cardsContainer);
      if (visibleCard) {
        this.updateMarkerColors(visibleCard);
      }
    });
  }
}
