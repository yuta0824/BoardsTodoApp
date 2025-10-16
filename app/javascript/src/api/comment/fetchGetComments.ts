import axios from "axios";

export const fetchGetComments = async (boardId: number, taskId: number) => {
  try {
    const response = await axios.get(
      `/boards/${boardId}/tasks/${taskId}/comments`
    );
    return response.data;
  } catch (error) {
    throw error;
  }
};
