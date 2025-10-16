import { fetchGetComments } from "../api/comment/fetchGetComments";

export const displayComments = async () => {
  // TODO: 動的に取得する
  const boardId = 82;
  const taskId = 270;

  // TODO: dataからDOMを生成
  const data = await fetchGetComments(boardId, taskId);
  console.log(data);
};
