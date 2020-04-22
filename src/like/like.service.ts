import { connection } from '../app/database/mysql';

/**
 * 保存用户点赞内容
 */
export const createUserLikePost = async (userId: number, postId: number) => {
  // 准备查询
  const statement = `
    INSERT INTO
      user_like_post (userId, postId)
    VALUES (?, ?)
  `;

  // 执行查询
  const [data] = await connection.promise().query(statement, [userId, postId]);

  // 提供数据
  return data;
};
