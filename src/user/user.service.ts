import { connection } from '../app/database/mysql';
import { UserModel } from './user.model';

/**
 * 创建用户
 */
export const createUser = async (user: UserModel) => {
  // 准备查询
  const statement = `
    INSERT INTO user
    SET ?
  `;

  // 执行查询
  const [data] = await connection.promise().query(statement, user);

  // 提供数据
  return data;
};