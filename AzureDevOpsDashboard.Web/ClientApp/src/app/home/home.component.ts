import { Component, inject, OnInit } from '@angular/core';
import { AuthService } from '../auth/auth.service';
import { init, waitForInit } from '../async-init';
import { UserService } from '../user-service';
import { AccountInfo } from '@azure/msal-browser';
import { PatComponent } from '../pat/pat.component';
import { AzureService } from '../azure/azure.service';
import { WorkItemDTO } from '../azure/workItem.dto';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrl: './home.component.scss',
  providers: [PatComponent],
  imports: [PatComponent]
})
export class HomeComponent implements OnInit {
  authService: AuthService = inject(AuthService);
  userService: UserService = inject(UserService);
  azureService: AzureService = inject(AzureService);

  token: string | null | undefined = '';
  photo: any | null = null;
  account: AccountInfo | undefined | null;
  workItems: WorkItemDTO[] = [];

  @waitForInit
  ngOnInit() {
    this.account = this.authService.getAccount();
  }

  @init
  private async asyncInit() {
    this.token = await this.authService.getToken();
    this.photo = await this.userService.getUserPhoto(this.token);
  }

  logout() {
    this.authService.logout();
  }

  async onIterationClick() {
    this.workItems = await this.azureService.getInterationInfo(this.account?.username || '', sessionStorage.getItem('PAT') || '');
  }
}
