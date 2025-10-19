export const hasListenerAttached = (element: HTMLElement): boolean => {
  return element.dataset.listenerAttached === "true";
};

export const markListenerAttached = (element: HTMLElement): void => {
  element.dataset.listenerAttached = "true";
};
