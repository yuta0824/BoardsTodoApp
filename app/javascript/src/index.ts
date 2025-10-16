import { closeFlash } from "./modules/closeFlash";

document.addEventListener("turbo:load", closeFlash);
document.addEventListener("turbo:render", closeFlash);
