import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["snowEmoji"]
  connect() {
  }
  changeEmoji(event) {
    const snowEmojis = ['☀ CLEAR','⛆ RAIN','🧊 ICE','🌨️ SNOWY','❄️ POW!'];
    let index = event.currentTarget.value
    this.snowEmojiTarget.innerText = snowEmojis[index]
  }
}
