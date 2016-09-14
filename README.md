# FirebaseSample

## Usage

### Create Firebase Project

https://www.firebase.com/

### Add plist

Create Application of Firebase and add GoogleServie-info.plist to project root.

### Pod update

```
pod update
```

### Database Rules

Set database rules below at web console.

```
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```
