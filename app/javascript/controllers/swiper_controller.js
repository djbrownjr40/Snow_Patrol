import { Controller } from "@hotwired/stimulus"

import Swiper from 'swiper';
// // import Swiper styles
// import 'swiper/css';

// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    console.log("test swiper")
  }
}
