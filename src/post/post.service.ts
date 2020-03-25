import { connection } from '../app/database/mysql';

/**
 * 获取内容列表
 */
export const getPosts = async () => {
  const statement = `
    SELECT * FROM post
  `;

  const [data] = await connection.promise().query(statement);

  return data;
};