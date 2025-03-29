import { EnvironmentPlugin } from 'webpack';

const dotenv = require('dotenv-webpack');

module.exports = {
  plugins: [new dotenv({
    path: process?.env?.['NODE_ENV'] === 'development' ? '.env.local' : '.env',
    systemvars: true
  })],
};