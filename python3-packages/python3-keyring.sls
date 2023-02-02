export-keyring-backend-setenv:
  environ.setenv:
    - name: PYTHON_KEYRING_BACKEND
    - value: keyring.backends.null.Keyring
