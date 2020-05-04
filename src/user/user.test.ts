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

/**
 * 创建用户
 */
describe('测试创建用户接口', () => {
  test('创建用户时必须提供用户名', async () => {
    // 请求接口
    const response = await request(app)
      .post('/users')
      .send({ password: testUser.password });

    // 做出断言
    expect(response.status).toBe(400);
    expect(response.body).toEqual({ message: '请提供用户名' });
  });

  test('创建用户时必须提供密码', async () => {
    // 请求接口
    const response = await request(app)
      .post('/users')
      .send({ name: testUser.name });

    // 做出断言
    expect(response.status).toBe(400);
    expect(response.body).toEqual({ message: '请提供用户密码' });
  });

  test('成功创建用户以后，响应状态码应该是 201', async () => {
    // 请求接口
    const response = await request(app)
      .post('/users')
      .send(testUser);

    // 设置创建的测试用户
    testUserCreated = await getUserById(response.body.insertId, {
      password: true,
    });

    // 做出断言
    expect(response.status).toBe(201);
  });
});
