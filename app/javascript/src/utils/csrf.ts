import axios, { AxiosRequestConfig } from "axios";

export const jsonRequest = (): AxiosRequestConfig => ({
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
  },
});

export const ensureCsrfToken = () => {
  const token = document.querySelector<HTMLMetaElement>(
    'meta[name="csrf-token"]'
  )?.content;

  if (token) axios.defaults.headers.common["X-CSRF-Token"] = token;
};
