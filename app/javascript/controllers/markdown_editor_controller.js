import { Controller } from "@hotwired/stimulus";
import EasyMDE from "easymde";

export default class extends Controller {
  static targets = ["textarea"];

  connect() {
    console.log("🚀 Stimulus: Markdown Editor Controller Connected!");

    if (this.hasTextareaTarget) {
      console.log("🎯 Found textarea target:", this.textareaTarget);

      this.editor = new EasyMDE({
        element: this.textareaTarget,
        sideBySideFullscreen: false,
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
          "table",
          "|",
          "preview",
          "side-by-side",
          "|",
          "guide"
        ],
        renderingConfig: {
          singleLineBreaks: false,
        },
        minHeight: "300px",
        maxHeight: "500px",
      });

      console.log("✅ EasyMDE Initialized!");

      setTimeout(() => {
        const scroller = this.editor.codemirror.getScrollerElement();

        // 🔄 Ensure scrolling behavior
        scroller.style.overflowY = "scroll";
        scroller.style.scrollbarWidth = "auto"; 

        // 🚀 Fix: Prevent CodeMirror from blocking scrollbar interactions
        scroller.addEventListener("mousedown", (e) => {
          e.stopPropagation(); // Prevent CodeMirror from hijacking scroll events
        });

        console.log("🔄 EasyMDE Scroll Behavior Fixed!");
      }, 500);
    } else {
      console.warn("⚠️ No textarea target found!");
    }
  }
}
