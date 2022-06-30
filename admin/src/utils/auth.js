export function getToken(tokenKey) {
  return sessionStorage.getItem(tokenKey);
}

export function setToken(tokenKey, token) {
  return sessionStorage.setItem(tokenKey, token)
}

export function removeToken(tokenKey) {
  return sessionStorage.removeItem(tokenKey);
}
