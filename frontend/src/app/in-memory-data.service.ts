import {InMemoryDbService} from 'angular-in-memory-web-api';
export class InMemoryDataService implements InMemoryDbService {
    createDb() {
        let rices = [
            {id: 1, name: 'Gao A', price: 1000, description: 'Gao A', review: 'Chat luong tot', img: './assets/img/rice2.jpg'},
            {id: 2, name: 'Gao B', price: 2000, description: 'Gao A', review: 'Chat luong tot', img: './assets/img/rice2.jpg'},
            {id: 3, name: 'Gao C', price: 4000, description: 'Gao A', review: 'Chat luong tot', img: './assets/img/rice2.jpg'},
            {id: 4, name: 'Gao D', price: 1500, description: 'Gao A', review: 'Chat luong tot', img: './assets/img/rice2.jpg'},
            {id: 5, name: 'Gao E', price: 2340, description: 'Gao A', review: 'Chat luong tot', img: './assets/img/rice2.jpg'},
            {id: 6, name: 'Gao F', price: 3410, description: 'Gao A', review: 'Chat luong tot', img: './assets/img/rice2.jpg'},
            {id: 7, name: 'Gao G', price: 700, description: 'Gao A', review: 'Chat luong tot', img: './assets/img/rice2.jpg'},
        ];
        return {rices};
    }
}