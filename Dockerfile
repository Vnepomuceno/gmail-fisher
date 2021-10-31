FROM python:3.9-slim

# Set up and activate virtual environment
ENV VIRTUAL_ENV "/venv"
RUN python -m venv $VIRTUAL_ENV
ENV PATH "$VIRTUAL_ENV/bin:$PATH"

WORKDIR ${VIRTUAL_ENV}
COPY ./pyproject.toml ${VIRTUAL_ENV}/
COPY ./poetry.lock ${VIRTUAL_ENV}/

# Python commands run inside the virtual environment
RUN python -m pip install --no-cache-dir --upgrade pip==21.3.1 \
        poetry==1.1.11 \
    && poetry install

COPY . ${VIRTUAL_ENV}/

CMD ["./export_expenses.sh", "gmail_fisher/output/food_expenses.json", "../finance-police/finance_police/data"]