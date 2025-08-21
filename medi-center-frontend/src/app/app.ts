import { Component } from '@angular/core';
import { Login } from './pages/login/login';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [Login],
  templateUrl: './app.html', 
  styleUrls: ['./app.css']
})
export class App {
  protected title = 'medi-center-frontend';
}
