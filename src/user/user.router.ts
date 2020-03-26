import express from 'express';
import * as userController from './user.controller';
import { validateUserData } from './user.middleware';

const router = express.Router();

/**
 * 创建用户
 */
router.post('/users', validateUserData, userController.store);

/**
 * 导出路由
 */
export default router;