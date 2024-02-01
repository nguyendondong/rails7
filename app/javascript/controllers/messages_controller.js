import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static  targets = ["form", "openSearchInputContent", "closeSearchInputContent"];
    static  values = {
        open: Boolean
    }
    connect() {
        if (this.openValue) {
        this.openSearchInput();
        } else {
            this.closeSearchInput();
        }
    }
    search() {
        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
            this.formTarget.requestSubmit()
        }, 100);
    }

    openSearchInput() {
        this.formTarget.hidden = false;
        this.closeSearchInputContentTarget.hidden = false;
        this.openSearchInputContentTarget.hidden = true;

    }
    closeSearchInput() {
        this.formTarget.hidden = true;
        this.closeSearchInputContentTarget.hidden = true;
        this.openSearchInputContentTarget.hidden = false;

    }
    submitForm(){

    }

}
