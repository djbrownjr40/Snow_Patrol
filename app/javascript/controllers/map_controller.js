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
    console.log(this.mapTarget);
    console.log(this.apiKeyValue);
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
      const marker = new mapboxgl.Marker()
        .setLngLat([markerData.lng, markerData.lat])
        .addTo(this.map);

      // Attach the ski resort ID to the marker element
      marker.getElement().setAttribute("data-ski-resort-id", markerData.marker_id);
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

    console.log(this.map);
    this.markersValue.forEach(marker => {
      const new_marker = this.map.getLayer(marker.id);
      console.log(new_marker);
      if (new_marker) {
        if (marker.id === skiResortId) {
          // Change marker color for the visible card
          new_marker.getElement().style.color = "red";
        } else {
          // Reset color for other markers
          new_marker.getElement().style.color = "blue";
        }
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
