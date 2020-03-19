import express from 'express';

/**
 * 创建应用
 */
const app = express();

/**
 * 处理 JSON
 */
app.use(express.json());

/**
 * 导出应用
 */
export default app;