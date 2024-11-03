import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="rating"
export default class extends Controller {
  static targets = ["emoji"]
  connect() {
    console.log("hello")
  }
  changeEmoji(event) {
    console.log(event.currentTarget.value)
    console.log(this.emojiTarget)
    const emojis = ['','😠','😦','😑','😀','😍'];
    let index = event.currentTarget.value
    this.emojiTarget.innerText = emojis[index]
  }
}
