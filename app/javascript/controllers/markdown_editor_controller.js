import { Controller } from "@hotwired/stimulus";
import EasyMDE from "easymde";

// Connects to data-controller="markdown-editor"
export default class extends Controller {
  static targets = ["textarea"];

  connect() {
    this.editor = new EasyMDE({
      element: this.textareaTarget,
      spellChecker: false,
      autosave: {
        enabled: true,
        uniqueId: "blog_post_content",
        delay: 1000,
      },
      toolbar: [
        "bold",
        "italic",
        "heading",
        "|",
        "quote",
        "unordered-list",
        "ordered-list",
        "|",
        "link",
        "image",
        "|",
        "preview",
        "side-by-side",
        "fullscreen",
        "|",
        "guide"
      ],
    });
  }
}
