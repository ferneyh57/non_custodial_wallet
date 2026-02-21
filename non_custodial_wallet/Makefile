.PHONY: clean get l10n build watch analyze format test run-dev

clean:
	flutter clean

get:
	flutter pub get

l10n:
	flutter gen-l10n

build:
	dart run build_runner build --delete-conflicting-outputs

watch:
	dart run build_runner watch --delete-conflicting-outputs

analyze:
	flutter analyze

format:
	dart format .

test:
	flutter test

run-dev:
	flutter run -d chrome --web-renderer canvaskit
