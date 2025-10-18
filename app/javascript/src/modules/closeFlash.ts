export const closeFlash = () => {
  const buttons = document.querySelectorAll(".js-flash-close-button");
  buttons.forEach((button) => {
    button.addEventListener("click", () => {
      const flash = button.closest(".js-flash");
      flash?.remove();
    });
  });
};
