import express from 'express';
import * as userController from './user.controller';
import { validateUserData, hashPassword } from './user.middleware';

const router = express.Router();

/**
 * 创建用户
 */
router.post('/users', validateUserData, hashPassword, userController.store);

/**
 * 用户帐户
 */
router.get('/users/:userId', userController.show);

/**
 * 导出路由
 */
export default router;
