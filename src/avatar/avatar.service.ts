import { connection } from '../app/database/mysql';
import { AvatarModel } from './avatar.model';

/**
 * 保存头像文件信息
 */
export const createAvatar = async (avatar: AvatarModel) => {
  // 准备查询
  const statement = `
    INSERT INTO avatar
    SET ?
  `;

  // 执行查询
  const [data] = await connection.promise().query(statement, avatar);

  // 提供数据
  return data;
};

/**
 * 按用户 ID 查找 头像
 */
export const findAvatarByUserId = async (userId: number) => {
  // 准备查询
  const statement = `
    SELECT *
    FROM avatar
    WHERE userId = ?
    ORDER BY avatar.id DESC
    LIMIT 1
  `;

  // 执行查询
  const [data] = await connection.promise().query(statement, userId);

  // 提供数据
  return data[0];
};
