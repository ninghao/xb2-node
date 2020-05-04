import request from 'supertest';
import bcrypt from 'bcrypt';
import app from '../app';
import { connection } from '../app/database/mysql';
import { signToken } from '../auth/auth.service';
import { deleteUser, getUserById } from './user.service';
import { UserModel } from './user.model';

/**
 * 准备测试
 */
const testUser: UserModel = {
  name: 'xb2-test-user-name',
  password: '111111',
};

const testUserUpdated: UserModel = {
  name: 'xb2-test-user-new-name',
  password: '222222',
};

let testUserCreated: UserModel;

/**
 * 所有测试结束后
 */
afterAll(async () => {
  // 删除测试用户
  if (testUserCreated) {
    await deleteUser(testUserCreated.id);
  }

  // 断开数据服务连接
  connection.end();
});
