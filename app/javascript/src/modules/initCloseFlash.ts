export const initCloseFlash = () => {
  const container = document.querySelector<HTMLElement>("#js-flash-container");
  if (!container || container.dataset.flashCloseListenerAttached === "true")
    return;

  container.addEventListener("click", (e) => {
    const target = e.target as HTMLElement;
    const button = target.closest<HTMLElement>(".js-flash-close-button");
    if (!button) return;

    const flash = button.closest(".js-flash");
    if (!flash) return;

    flash?.remove();
  });

  container.dataset.flashCloseListenerAttached = "true";
};
