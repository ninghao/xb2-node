import { connection } from '../app/database/mysql';

/**
 * 获取内容列表
 */
export const getPosts = async () => {
  const statement = `
    SELECT
      post.id,
      post.title,
      post.content,
      JSON_OBJECT(
        'id', user.id,
        'name', user.name
      ) as user
    FROM post
    LEFT JOIN user
      ON user.id = post.userId
  `;

  const [data] = await connection.promise().query(statement);

  return data;
};