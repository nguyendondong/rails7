import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("ket noi dc roi");
    }
    static  targets = ["form", "a"]
    search() {
        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
            this.formTarget.requestSubmit()
        }, 100);
    }

    hide(){
        this.element.remove();
    }

}
