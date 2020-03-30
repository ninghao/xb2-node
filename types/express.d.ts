import { TokenPayload } from '../src/auth/auth.interface';

declare global {
  namespace Express {
    export interface Request {
      user: TokenPayload;
    }
  }
}
