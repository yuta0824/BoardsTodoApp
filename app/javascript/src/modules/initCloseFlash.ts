import {
  hasListenerAttached,
  markListenerAttached,
} from "../utils/eventListener";

export const initCloseFlash = () => {
  const container = document.querySelector<HTMLElement>("#js-flash-container");
  if (!container || hasListenerAttached(container)) return;

  container.addEventListener("click", (e) => {
    const target = e.target as HTMLElement;
    const button = target?.closest<HTMLElement>(".js-flash-close-button");
    const flash = button?.closest(".js-flash");
    if (!flash || !button) return;

    flash.remove();
  });

  markListenerAttached(container);
};
