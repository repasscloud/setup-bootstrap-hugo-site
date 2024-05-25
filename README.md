# Hugo Site Setup Script

This script sets up a new Hugo site using the `hugo-bootstrap-theme` and performs various configurations.

## Prerequisites

- Hugo installed on your system.
- Git installed on your system.

## Description

This script will:
1. Clone the `hugo-bootstrap-theme` repository into a specified directory.
2. Copy the contents of the `exampleSite` directory to the root of the project.
3. Remove the `exampleSite` directory.
4. Modify `config.toml` to update `baseURL` and `timeZone`, and add parameters for `mainButtonURL` and `mainButtonText`.
5. Modify `index.html` to use the parameters for the button link.

## Usage

1. **Clone the repository or create the script file**:

    ```sh
    git clone  https://github.com/repasscloud/setup-bootstrap-hugo-site.git
    cd setup_bootstrap_hugo_site
    ```

    Or create the script file directly:

    ```sh
    nano setup_hugo_site.sh
    ```

2. **Copy the following script into `setup_hugo_site.sh`**:

    ```sh
    #!/bin/zsh

    # Check if a directory name was provided
    if [ -z "$1" ]; then
      echo "Usage: $0 <directory>"
      exit 1
    fi

    TARGET_DIR=$1

    # Step 1: Clone the git theme URL into the target directory
    git clone https://github.com/repasscloud/setup-bootstrap-hugo-site.git "$TARGET_DIR"

    # Step 2: Navigate into the directory
    cd "$TARGET_DIR"

    # Step 3: Copy the contents of exampleSite to the root of the project
    cp -r exampleSite/* .

    # Step 4: Remove the exampleSite directory
    rm -rf exampleSite

    # Step 5: Modify config.toml to update baseURL and timeZone, and add params
    CONFIG_FILE=./config/_default/config.toml

    # Replace baseURL
    sed -i.bak "s|baseURL = 'https://filipecarneiro.github.io/hugo-bootstrap-theme/'|baseURL = ''|" "$CONFIG_FILE"

    # Replace timeZone
    sed -i.bak "s|timeZone = 'Europe/London'|timeZone = 'Australia/Sydney'|" "$CONFIG_FILE"

    # Add params at the bottom
    cat <<EOL >> "$CONFIG_FILE"

    [params]
      mainButtonURL = "https://example.com/get-started"  # Set your desired URL here
      mainButtonText = "Get Started"
    EOL

    # Step 6: Modify index.html to use the params for the button
    INDEX_FILE=./layouts/index.html

    # Replace the href and text in the button link
    sed -i.bak 's|<a class="btn btn-bd-primary btn-lg px-4 mb-2" href="https://github.com/filipecarneiro/hugo-bootstrap-theme" role="button">Get Started</a>|<a class="btn btn-bd-primary btn-lg px-4 mb-2" href="{{ .Site.Params.mainButtonURL }}" role="button">{{ .Site.Params.mainButtonText }}</a>|' "$INDEX_FILE"

    echo "Setup complete. You can now run 'hugo server -D --disableFastRender' to start your site."
    ```

3. **Make the script executable**:

    ```sh
    chmod +x setup_hugo_site.sh
    ```

4. **Run the script with the target directory as an argument**:

    ```sh
    ./setup_hugo_site.sh my-hugo-site
    ```

## Configuration

The script performs the following configurations:

- **baseURL**: Sets the `baseURL` in `config.toml` to an empty string for local development.
- **timeZone**: Changes the `timeZone` in `config.toml` to `Australia/Sydney`.
- **Parameters**: Adds `mainButtonURL` and `mainButtonText` to the `params` section in `config.toml`.

## Testing

After running the script, start the Hugo server to verify the setup:

```sh
cd my-hugo-site
hugo server -D --disableFastRender
```

Open your browser and navigate to http://localhost:1313/ to see the site.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.