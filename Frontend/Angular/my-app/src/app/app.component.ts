import { Component } from '@angular/core';
import { Http, Response } from '@angular/http';
import 'rxjs/add/operator/map';
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  users : any;
  apiURL = 'https://5b7f7cd4af5e5600144d5e8d.mockapi.io/TT';
  constructor(private http: Http)
  {
    this.http.get(this.apiURL)
    .toPromise()
    .then(res => res.json())
    .then(r => (this.users = r)
  )};
  sers= [
    {
        "id": "1",
        "name": "Woodrow_Windler43@gmail.com"
    },
    {
        "id": "2",
        "name": "Yasmeen_King27@hotmail.com"
    }
  ]
  id="";
  name="";
  EditPerson(id)
  {
    this.id = this.users[id].id;
    this.name = this.users[id].id;
  }
  title = 'my-app';
}

