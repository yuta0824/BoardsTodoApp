import axios from "axios";

export const getTest = () => {
  axios.get("/").then((response) => console.log(response));
};
