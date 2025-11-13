import axios from 'axios';
import { OMNI_TOKEN } from './constants';

export const httpService = axios.create({
  baseURL: 'http://localhost:3001/api/v1',
  headers: {
    "Content-Type": 'application/json',
    'Authorization': `Bearer ${OMNI_TOKEN}`,
    // 'Host': 'partnerharkendata.omniapp.co',
    'Accept': '*/*',
  },
});

export const getDocuments = async () => {
  try { 
    const response = await httpService.get('/documents');
    return response.data;
  } catch (error) {
    console.error('Error fetching documents:', error);
    return [];
  }
};

export const getQueryResponse = async (payload: any) => {
  try {
    const response = await httpService.post('/query/run', payload);
    return response.data;
  } catch (error) {
    console.error('Error fetching query response:', error);
    return [];
  }
};
