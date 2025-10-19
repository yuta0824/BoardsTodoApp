import {
  hasListenerAttached,
  markListenerAttached,
} from "../utils/eventListener";

export const initCloseFlash = () => {
  const container = document.querySelector<HTMLElement>("#js-flash-container");
  if (!container || hasListenerAttached(container)) return;

  container.addEventListener("click", (e) => {
    const target = e.target as HTMLElement;
    const button = target.closest(".js-flash-close-button");
    if (!button) return;
    const flash = button.closest(".js-flash");
    if (!flash) return;

    flash.remove();
  });

  markListenerAttached(container);
};
