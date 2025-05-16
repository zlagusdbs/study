# Git
  - Git
  - GitHub
  - Git LAB

---

# Git
## config
- local
  ```console
  # location: .git/config
  user> git config --local [OPTIONS]
  ```

- global
  ```console
  # location on Windows: C:\Users\\.gitconfig
  # location on unix: ~/.gitconfig
  user> git config --global [OPTIONS]
  ```

- system
  ```console
  # location on Windows: C:\ProgramData\Git\config
  # location on unix: $(prefix)/etc/gitconfig
  user> git config --system [OPTIONS]
  ```
  
cf> [https://www.atlassian.com/git/tutorials/setting-up-a-repository/git-config](https://www.atlassian.com/git/tutorials/setting-up-a-repository/git-config)

## Git Tag
- 조회
```
// 조회
# git tag

// 상세조회
# git show TAG_NAME
```
  
- 삭제
```
// Local
# git tag -d TAG_NAME

// Origin
# git push --delete origin TAG_NAME
```
  
- 생성
```
// Local
# git tag TAG_NAME

// Origin
# git push origin TAG_NAME
```


---

# GitHub

## Tip
### 대용량 파일 upload(100MB 이상)
#### git-lfs 설치
  - [https://git-lfs.github.com/](https://git-lfs.github.com/)
  
#### git-lfs 적용
  ```console
  [root@repository ~]# git lfs install
  [root@repository ~]# git lfs track "올릴파일.확장자"
  [root@repository ~]# git commit -m "comment"
  ```

#### BFG Repo-Cleaner
  - 기존에 100MB 보다 큰 파일의 로그를 강제로 삭제
  - jar download
    -https://rtyley.github.io/bfg-repo-cleaner/
    
  - download 된 jar file을 이용하여 아래 명령어 수행
  ```console
  [root@repository ~]# java -jar bfg-x.x.x.jar --strip-blobs-bigger-than 100M

  또는

  [root@repository ~]# git repack && git gc
  [root@repository ~]# java -jar bfg-x.x.x.jar --strip-blobs-bigger-than 100M
  ```

### Git Branch OverRide
  ```console
  [root@repository ~]# git checkout develop
  [root@repository ~]# git pull
  [root@repository ~]# git checkout master
  [root@repository ~]# git merge --strategy=ours develop
  [root@repository ~]# git checkout develop
  [root@repository ~]# git merge --no-ff master
  ```


---

# GitLab
