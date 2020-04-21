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
