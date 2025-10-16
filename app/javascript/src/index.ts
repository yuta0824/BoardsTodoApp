import { getTest } from "./api/getTest";
import { closeFlash } from "./modules/closeFlash";

document.addEventListener("turbo:load", () => {
  getTest();
  closeFlash();
});

document.addEventListener("turbo:render", closeFlash);
